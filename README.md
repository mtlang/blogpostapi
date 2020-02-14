# Blog Post API
A small, quick implementation of an API to manage blog posts. The API itself is built using [Flask](https://flask.palletsprojects.com/en/1.1.x/) and a sqlite database. This project is a proof of concept, and several steps would need to be taken to make it production-ready.

## Dependencies
Any system that is going to run this API will need to install the following first:

* [Python 3](https://www.python.org/downloads/)
* [Flask](https://flask.palletsprojects.com/en/1.1.x/installation/)

To deploy a server using the profided terraform file, you will instead need [Terraform](https://www.terraform.io/downloads.html).

## Running Locally

1. Ensure you have installed all dependencies
2. Clone this repository
4. Run `flask run --host=0.0.0.0` from this directory

## Running on AWS
1. Ensure you have Terraform installed and configured for your AWS account
2. Ensure your AWS account has a suitable public subnet and key pair for the server
3. Run `terraform apply` to create the server
4. Once the server is created, log in to your server with the username `ec2-user` and the key pair you specified
5. On the server use `yum` to install `git`, `python3`. SQLite should already be installed.\
6. Use pip to install flask: `sudo pip3 install flask`
6. Clone this repository on the server
7. In the same directory as the python file, run `flask run --host=0.0.0.0`

## Next steps
As I mentioned earlier, this PoC would need some changes before it could be considered production ready. The following are several of those changes:

* Enable termination protection on the EC2 instance
* Place the instance in a private subnet
* Use an ALB to make the instance publicly available
* Use a database engine capable of remote access, and run it separately from the web server
* Either implement the API using a serverless framework (Lambda, API gateway) or use an auto-scaling group to run as many instances as needed

It would also be useful to flesh the API out with additional methods (delete a post, edit an existing post, etc.).
