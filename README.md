# Elixir-FinalProject
En la raiz del proyecto se debe crear un archivo llamado variables.tf
adicinar la siguiente información:

variable "my_access_key" {
  description = "Access-key-for-AWS"
  default = "Access key ID"
}

variable "my_secret_key" {
  description = "Secret-key-for-AWS"
  default = "Secret access key"
}

variable "my_region" {
  default = "us-east-2"
}

variable "my_ami" {
  default = "ami-09558250a3419e7d0"
}

variable "my_instance_type"{
  default = "t2.small"
}

Los comandos para instalar postgres erlang y phoenix

Se dejan en el readme debido a que si se dejan en el main.tf no funcionan, en el caso de erlang descargar el tar.gz pero no lo logra descomprimir al igual que elixir y phoenix

key_name = "testfabio"
	user_data = <<-EOF
	        #!/bin/bash

					sudo yum update -y
				  sudo amazon-linux-extras install epel -y
					sudo yum install nginx

					sudo yum install postgresql postgresql-server postgresql-devel -y
					sudo service postgresql initdb
					sudo service postgresql start
					sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses='*'/"  /var/lib/pgsql/data/postgresql.conf
					sudo sed -i "s/#port = 5432/port = 5432/" /var/lib/pgsql/data/postgresql.conf
					sudo sed -i "s/peer/trust/" /var/lib/pgsql/data/pg_hba.conf
					sudo sed -i "s/ident/trust/" /var/lib/pgsql/data/pg_hba.conf
					sudo -u postgres psql -U postgres -d postgres -c "alter user postgres with password 'postgres';"
					sudo systemctl restart postgresql.service


					sudo yum install ncurses-devel openssl-devel
					sudo yum update
					sudo amazon-linux-extras install apel
					curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
					sudo wget https://erlang.org/download/otp_src_23.1.tar.gz
					sudo tar -zxvf otp_src_23.1.tar.gz
					sudo rm otp_src_23.1.tar.gz
					cd otp_src_23.1/
					sudo yum groupinstall "Development Tools" -y
					sudo ./configure
					sudo make
					sudo make install

					sudo wget https://github.com/elixir-lang/elixir/archive/v1.11.zip
					sudo unzip v1.11.zip
					sudo rm v1.11.zip
					cd v1.11
					sudo make
					sudo make install
