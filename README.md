ec2-sinatra-boilerplate
=======================

Get your Sinatra app up in the cloud ASAP...

So, this is a first iteration, pretty basic. Future features

* RVM (Or not, rbenv is so much easier...)
* Puppet (Currently in, super basic)
* Fog (To create the instance for you)
* Custom AMI (With Puppet installed already)

Currently, here's the things you need to do on the server before you go...

	sudo -s
	
	apt-get install chkconfig
	
	nginx=stable
	
	add-apt-repository ppa:nginx/$nginx
	
	apt-get update 
	
	apt-get install nginx

	sudo service nginx start

	fuser -n tcp 80

	kill -9 {running 80 process if it exists}

	sudo gem install sinatra haml