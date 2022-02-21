sudo apt-get update -y  >/dev/null
sudo apt-get install openjdk-8-jdk openjdk-8-jre -y >/dev/null
cat <<EOF | sudo tee /etc/profile.d/java_home.sh
export JAVA_HOME=\$(dirname \$(dirname \$(readlink \$(readlink \$(which javac)))))
export PATH=\$PATH:\$JAVA_HOME/bin
EOF
source /etc/profile.d/java_home.sh

