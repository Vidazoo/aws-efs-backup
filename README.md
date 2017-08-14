# aws-efs-backup
simple container that takes an efs and backups it to s3, requires `--privileged` tag due to mounting the efs
docker version can be found at docker hub at https://hub.docker.com/r/vidazoohub/aws-efs-backup/

requires the following envvars:
````````
EFS_ID = the EFS id
EFS_NAME = the EFS name
AWS_ACCESS_KEY_ID = your AWS account access key
AWS_SECRET_ACCESS_KEY = your AWS account secret access key
AWS_DEFAULT_REGION = the region where the EFS is
S3_BUCKET = s3 bucket to backup to
````````

the container will compress the EFS and upload it to s3 bucket and will proceed to exit with code 0 if everything ok and another code otherwise so it's easy to use as a cronjob or a metronome (DC/OS) job as in the example below:

``````
{
  "id": "aws-efs-backup",
  "run": {
    "cmd": "docker pull vidazoohub/aws-efs-backup:latest && docker run --privileged --rm -e EFS_ID=xxx -e EFS_NAME=xxx -e AWS_ACCESS_KEY_ID=xxx -e AWS_SECRET_ACCESS_KEY=xxx -e AWS_DEFAULT_REGION=us-east-1 -e S3_BUCKET=xxx vidazoohub/aws-efs-backup:latest",
    "cpus": 0.1,
    "mem": 512,
    "disk": 100
  },
  "schedules": [
    {
      "id": "default",
      "enabled": true,
      "cron": "0 2 * * *",
      "timezone": "UTC",
      "concurrencyPolicy": "ALLOW",
      "startingDeadlineSeconds": 600
    }
  ]
}
``````

