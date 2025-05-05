terrafrom {
    backend "s3" {
        bucket = "your-tfstate-bucket"
        key = "path/to/your/statefile"    #please check at a later point of time
        region = "us-east-1"
    }
}