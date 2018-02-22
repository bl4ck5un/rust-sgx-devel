FROM baiduxlab/sgx-rust

ENV PATH=$PATH:/root/.cargo/bin

RUN cargo install cargo-make && rustup component add rustfmt-preview

RUN apt-get update -qq && apt-get install -qq -y lsb-release

RUN apt-get install -y software-properties-common && \
    add-apt-repository ppa:neovim-ppa/stable -y && \
    apt-get update -qq && \
    apt-get install -qq -y neovim python-dev python-pip python3-dev python3-pip && \
    pip2 install --upgrade neovim && \
    pip3 install --upgrade neovim

RUN mkdir dev && \
    cd dev && git clone https://github.com/bl4ck5un/dotfiles && \
    cd dotfiles && \
    ./setup.sh && \
    cd nvim && \
    ./setup.sh && \
    nvim +PlugIn +qall

RUN cd /root/.config/nvim/plugged/YouCompleteMe && ./install.py --rust-completer
