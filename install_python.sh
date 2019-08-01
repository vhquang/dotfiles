function install_python() {
    if [[ "$(which python)" != *"conda"* || "$(which python)" != *"envs"* ]]; then
        echo "Not in non-base conda environment"

    else
    # TODO terminal color

        _TEMP_PY_SRC="/tmp/temp_install_python"
        echo "Setting up $_TEMP_PY_SRC" && echo ""
        rm -rf $_TEMP_PY_SRC && mkdir -p $_TEMP_PY_SRC && cd $_TEMP_PY_SRC

        _PY_URL=$1
        _py_tgz_file=$(basename $_PY_URL)
        unpack_dir="$_TEMP_PY_SRC/${_py_tgz_file%.*}"

        wget $_PY_URL
        tar xf $_py_tgz_file && cd $unpack_dir

        unset _PY_URL
        unset _TEMP_PY_SRC
        unset _py_tgz_file


        _py_bin_dir=$(dirname $(which python))
        install_dir="${_py_bin_dir%/bin}"

        make clean
        # TODO need to fix "OpenSSL module not found" error
        ./configure --prefix=$install_dir \
                    --enable-loadable-sqlite-extensions \
                    --with-ensurepip=install \
                    --with-openssl="$CONDA_PREFIX/include/" \
                    --with-ssl-default-suites=openssl && \
                make -j 8 && make install

        # set new python symlink
        echo "" && echo "Replacing $_py_bin_dir/python3" && echo ""
        _py_version=$($unpack_dir/python --version)
        _py_version_short=${_py_version:7:3}
        cd $_py_bin_dir
        rm -f "python3" "python"
        ln -s "python$_py_version_short" "python3"
        ln -s "python$_py_version_short" "python"

        unset unpack_dir
        unset _py_bin_dir
        unset install_dir
        unset _py_version
        unset _py_version_short

    fi
}


function setup_conda() {
    conda deactivate && conda remove --all -n py38b3 -y
    conda create -n py38b3 -y python=3 && conda activate py38b3
}

# setup_conda
install_python https://www.python.org/ftp/python/3.8.0/Python-3.8.0b3.tgz
