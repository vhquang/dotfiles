function install_python() {
    _TEMP_PY_SRC="/tmp/temp_install_python"
    echo "setting up $_TEMP_PY_SRC \n"
    rm -rf $_TEMP_PY_SRC && mkdir -p $_TEMP_PY_SRC && cd $_TEMP_PY_SRC

    _PY_URL=$1
    filename=$(basename $_PY_URL)
    unpack_dir="${filename%.*}"
    wget $_PY_URL
    tar xf $filename && cd $unpack_dir

    bin_dir=$(dirname $(which python))
    install_dir="${bin_dir%/bin}"

    echo "replacing $bin_dir/python3"
    rm -f "$bin_dir"/python3 "$bin_dr"/python
    ./configure --prefix=$install_dir && \
            make clean && \
            make -j 8 && make install

    unset _PY_URL
    unset filename
    unset _TEMP_PY_SRC
}


function setup_conda() {
    conda remove --all -yn py38b3
    conda create -n py38b3 -y python=3 && conda activate py38b3
}

setup_conda
install_python https://www.python.org/ftp/python/3.8.0/Python-3.8.0b3.tgz
