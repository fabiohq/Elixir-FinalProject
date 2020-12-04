

provider "aws" {
	region = var.my_region
	access_key = var.my_access_key
	secret_key = var.my_secret_key
}

resource "aws_instance" "InstallEC2" {
	ami = var.my_ami
	instance_type = var.my_instance_type

  tags = {
    Name = "EC2 Fabio"
  }
}

resource "aws_instance" "final" {
	ami = var.my_ami
	instance_type = var.my_instance_type

	user_data = <<-EOF
	        #!/bin/bash
					sudo yum groupinstall "Fabio"
					sudo yum install ncurses-devel openssl-devel
					wget http://www.erlang.org/download/otp_src_23.0.tar.gz
					tar -zxvf otp_src_19.2.tar.gz
					rm otp_src_19.2.tar.gz
					cd otp_src_19.2/
					./configure
					make
					sudo make install

					wget https://github.com/elixir-lang/elixir/archive/v1.4.2.zip
					unzip v1.4.2.zip
					cd elixir-1.4.2/
					make
					sudo make install
					echo "PATH=\$PATH:/home/ec2-user/elixir-1.4.2/bin" >> ~/.bashrc

					cd ..
					sudo yum install postgresql
					mix local.hex
					sudo yum install nodejs npm --enablerepo=epel
					sudo npm -g install brunch

					sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 4001

					git clone git://github.com/user_name/my-phonix-app

					cd my-phoenix-app
					npm install
					mix deps.get
					MIX_ENV=prod mix ecto.create
					MIX_ENV=prod mix ecto.migrate
					brunch build --production
					MIX_ENV=prod mix phoenix.digest
					MIX_ENV=prod PORT=4001 elixir --detached -S mix do compile, phoenix.server
		    EOF

	tags = {
		Name = "Phoenix Fabio"
	}
	vpc_security_group_ids = [aws_security_group.securitygroup.id]
}
#--------------------------------
resource "aws_security_group" "securitygroup" {
	name = "terraform-tcp-security-group-Fabio-prueba-final"

	ingress {
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}
