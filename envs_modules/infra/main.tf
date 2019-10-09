resource "aws_launch_configuration" "launch_configuration" {
	name = "${var.environment}-launch-configuration-instance"
	image_id = "ami-04681a1dbd79675a5"
	instance_type = "t3.micro"
}

resource "aws_autoscaling_group" "autoscaling_group" {
	launch_configuration = "${aws_launch_configuration.launch_configuration.id}"
	availability_zones = ["${var.azone}"]
	min_size = "${var.min_size}"
	max_size = "${var.max_size}"
}