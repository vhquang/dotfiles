function install_python() {
    # TODO check conda not base
    if [[ "$(which python)" != *"conda"* || "$(which python)" != *"envs"* ]]; then
        echo "Not in non-base conda environment"
    else
    # TODO terminal color
    _TEMP_PY_SRC="/tmp/temp_install_python"
    echo "setting up $_TEMP_PY_SRC" && echo ""
    # rm -rf $_TEMP_PY_SRC && mkdir -p $_TEMP_PY_SRC && cd $_TEMP_PY_SRC

    # _PY_URL=$1
    # _py_tgz_file=$(basename $_PY_URL)
    # unpack_dir="${_py_tgz_file%.*}"

    # wget $_PY_URL
    # tar xf $_py_tgz_file && cd $unpack_dir

    # bin_dir=$(dirname $(which python))
    # install_dir="${bin_dir%/bin}"

    # echo "replacing $bin_dir/python3"
    # rm -f "$bin_dir"/python3 "$bin_dr"/python
    # ./configure --prefix=$install_dir && \
    #         make clean && \
    #         make -j 8 && make install

    # # TODO unset all vars
    # unset _PY_URL
    # unset _TEMP_PY_SRC
    # unset _py_tgz_file
    # unset unpack_dir
    fi
}


function setup_conda() {
    conda remove --all -n py38b3 -y
    conda create -n py38b3 -y python=3 && conda activate py38b3
}

# setup_conda
install_python https://www.python.org/ftp/python/3.8.0/Python-3.8.0b3.tgz
