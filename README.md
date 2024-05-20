# About this repository:

Alternative Docker images based on Ubuntu LTS 22.04 containing aws-cli, [instead of the original images](https://hub.docker.com/r/amazon/aws-cli/tags) from Amazon based ond Amazon Linux 2.

Versions 1.x and 2.x are available.

## How it works

Container run in `user` context with uid/gid stat from folder /home/user/workspace, default is 1000:1000

## AWS credentials:

Mounts aws credentials file or give envirioment variables


## Workdir

Optional mount workdir directory to /home/user/workspace

## Exmaples

`docker run -v "$(realpath ~/.aws/):/home/user/.aws" -e AWS_PROFILE=your_profile_name  mppiotrowski/aws-cli:v2 s3 ls`

`docker run -v "$(realpath ~/.aws/):/home/user/.aws" -v "path_to_workdir_on_your_computer:/home/user/workdir" -e AWS_PROFILE=your_profile_name mppiotrowski/aws-cli:v2 "s3 cp --recursive s3://your_bucket_name/ .`

