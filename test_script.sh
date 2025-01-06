cat > test_script.sh <<EOF
#!/bin/bash

# Pull the latest image from the repository (optional if testing locally built image)
docker pull <your_dockerhub_repo>/<image_name>:<tag>

# Run the container in detached mode
docker run -d --name test_container -p 8080:80 <your_dockerhub_repo>/<image_name>:<tag>

# Test if the application is running
curl -f http://localhost:8080 || { 
    echo "Test failed: Application not reachable"; 
    docker logs test_container; 
    docker rm -f test_container; 
    exit 1; 
}

echo "Test passed: Application is reachable"

# Clean up the container
docker rm -f test_container
EOF
