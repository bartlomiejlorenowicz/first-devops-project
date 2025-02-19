# Oficjalny obraz Ubuntu
FROM ubuntu:latest

# 1. Aktualizacja i instalacja podstawowych narzędzi + zsh + sudo
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
      git \
      curl \
      wget \
      unzip \
      htop \
      tree \
      jq \
      zsh \
      sudo

# 2. Instalacja Dockera (skrypt get.docker.com)
RUN curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh get-docker.sh

# Domyślnie pozostajemy przy użytkowniku root

# 3. Konfiguracja Gita (dla użytkownika root)
RUN git config --global user.name "Twoje Imię" && \
    git config --global user.email "twoj.email@example.com" && \
    git config --global alias.s "status -s" && \
    git config --global alias.lg "log --oneline --graph --decorate" && \
    git config --global alias.amend "commit --amend --no-edit" && \
    git config --global alias.undo "reset HEAD~1 --mixed"

# 4. Instalacja Oh My Zsh i wtyczki zsh-autosuggestions (dla root)
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || true && \
    git clone https://github.com/zsh-users/zsh-autosuggestions \
      ${ZSH_CUSTOM:-/root/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions)/' /root/.zshrc

# 5. Zsh jako powłoka startowa
CMD ["/bin/zsh"]
