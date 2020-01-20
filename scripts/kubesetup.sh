curl https://s3.amazonaws.com/aws-cli/awscli-bundle.zip -o awscli-bundle.zip
sudo apt-get update
sudo apt install unzip python -y
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
/usr/local/bin/aws --version
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops
export KOPS_STATE_STORE=s3://demo.k8s.coviam.net >> /home/ubuntu/.bashrc
sudo -u ubuntu ssh-keygen -q -t rsa -f /home/ubuntu/.ssh/id_rsa -C "" -N ""
#kops create cluster --cloud=aws --zones=us-east-1b --name=demo.k8s.coviam.net --dns-zone=coviam.net --dns private
#kops update cluster --name demo.k8s.coviam.net --yes
#kops create cluster --yes --state=s3://demo.k8s.coviam.net --zones=us-east-1b --node-count=2 --node-size=t2.micro --master-size=t2.micro --name=test.k8s.local --dns-zone=test.k8s.local --dns private
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get install apt-transport-https ca-certificates -y
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install google-cloud-sdk -y
sudo apt-get install google-cloud-sdk-app-engine-python google-cloud-sdk-app-engine-python-extras google-cloud-sdk-app-engine-java google-cloud-sdk-app-engine-go google-cloud-sdk-datalab google-cloud-sdk-datastore-emulator google-cloud-sdk-pubsub-emulator google-cloud-sdk-cbt google-cloud-sdk-cloud-build-local google-cloud-sdk-bigtable-emulator -y
#kubectl create deployment simple-devops --image=viswanatha/simple-devops-image:latest
#docker pull viswanatha/simple-devops-image:latest
#kubectl create service loadbalancer simple-devops --tcp=80:8080