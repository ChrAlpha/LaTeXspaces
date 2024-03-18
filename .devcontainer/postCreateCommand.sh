sudo apt update -y
sudo apt install fonts-noto-cjk -y

# Install TeX Live by APT isn't recommended because it's not always the latest version
# sudo apt install texlive-full -y
# sudo apt install texlive -y

# Install TeX Live directly from the TeX Users Group
mkdir -p ~/tmp/texlive
cd ~/tmp/texlive
wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz 
zcat < install-tl-unx.tar.gz | tar xf -
cd $(ls -d install-tl-* | head -n 1)
sudo perl ./install-tl --no-interaction

# Add TeX Live to PATH
latest_texlive_path="$(ls -d /usr/local/texlive/[0-9]* | sort -n | tail -1)/bin/x86_64-linux"
echo "export PATH=\"$latest_texlive_path:\$PATH\"" >> ~/.bashrc
echo "export PATH=\"$latest_texlive_path:\$PATH\"" >> ~/.zshrc
echo "export PATH=\"$latest_texlive_path:\$PATH\"" >> ~/.profile

# USERMODE init & Install common TeX Live packages
# sudo apt install texlive-guesswhich -y
tlmgr init-usertree
tlmgr --usermode install biblatex fontspec microtype geometry hyperref graphicx xcolor cleveref babel tabularx caption enumitem tikz pgf xecjk
sudo env PATH=$PATH tlmgr install latexmk latexindent chktex kpsewhich lacheck synctex texcount texdoc
sudo env PATH=$PATH tlmgr path add
