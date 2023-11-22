
# Pull base image
FROM ubuntu:latest

# Update and install packages
RUN apt-get update -y
RUN apt-get install -y curl git zsh sudo \
    dirmngr gpg curl gawk wget

COPY --from=condaforge/miniforge3:latest /opt/conda /opt/conda

ENV PATH=/opt/conda/bin:$PATH

# Usage examples
RUN set -ex && \
    conda config --set always_yes yes --set changeps1 no && \
    conda info -a && \
    conda config --add channels conda-forge && \
    conda install --quiet --freeze-installed -c main conda-pack

# Install asdf separately
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
ENV PATH="/root/.asdf/bin:/root/.asdf/shims:$PATH"

# Install latest asdf plugins, and set default versions
RUN asdf plugin add golang
RUN asdf install golang latest
RUN asdf global golang latest

RUN asdf plugin add nodejs
RUN asdf install nodejs latest
RUN asdf global nodejs latest

RUN asdf plugin add rust
RUN asdf install rust latest
RUN asdf global rust latest

# Install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#
COPY setup.sh /opt/setup.sh

# create new user, set default, and set root perms
RUN useradd -ms /bin/zsh natalie
RUN chsh -s $(which zsh)
# add user to sudo group
RUN usermod -aG sudo natalie
# no password for sudo
RUN echo 'natalie ALL=(ALL) NOPASSWD:ALL' | tee -a /etc/sudoers
USER natalie
WORKDIR /home/natalie