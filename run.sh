function install_python() {
    _tmp_dir="/tmp/temp_install_python"
    echo "setting up $_tmp_dir"
    rm -rf $_tmp_dir && mkdir -p $_tmp_dir && cd $_tmp_dir

    url=$1
    filename=$(basename $url)
    unpack_dir="${filename%.*}"
    wget $url
    tar xvf $filename && cd $unpack_dir

    bin_dir=$(dirname $(which python))
    install_dir="${bin_dir%/bin}"

    echo "replacing $bin_dir/python3"
    rm -f "$bin_dir"/python3
    ./configure --prefix=$install_dir
    make clean && make -j 8 && make install

    unset url
    unset filename
    unset _tmp_dir
}


function setup_conda() {
    conda remove --all -yn py38b3
    conda create -yn py38b3 python=3 && conda activate py38b3
}

setup_conda
install_python https://www.python.org/ftp/python/3.8.0/Python-3.8.0b3.tgz
