[
    {
        "essential": true,
        "name": "${name}",
        "image": "${docker_image}:${docker_image_tag}",
        "environment":[
            ${environment}
        ],
        "secrets": [
            ${secrets}
        ],
        "portMappings": [
            {
                "containerPort": ${container_port},
                "hostPort": ${host_port},
                "protocol": "tcp"
            }
        ],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group" : "${log_group}",
                "awslogs-region": "${region}",
                "awslogs-stream-prefix": "ecs"
            }
        }
    }
]

