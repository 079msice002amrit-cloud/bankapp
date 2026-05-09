pipeline {
    agent any
    stages {
        stage("Clone Code") {
            steps {
                echo "cloning"
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/SakshamShrestha10/bankapp.git'
            }
        }
        stage("Build Image") {
            steps {
                echo "Building Image"
                sh "docker build -t bankapp ."
            }
        }
        stage("Push Image to dockerhub") {
            steps {
                echo "Pushing Image"
                withCredentials([usernamePassword(credentialsId:"dockerhub", usernameVariable:"user", passwordVariable: "password")]) {
                sh "docker tag bankapp ${env.user}/bankapp:latest"
                sh "docker login -u ${env.user} -p ${env.password}"
                sh "docker push ${env.user}/bankapp:latest"
                }
            }
        }
        stage("ssh into server") {
            steps {
                sshagent(['ssh-deployment']) {
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@52.91.165.106 "cd bank-app && docker-compose up --build -d"'
                }
            }
        }
        // stage("Deploy Image") {
        //     steps {
        //         echo "Deploying Image"
        //         sh "docker-compose down && docker-compose up -d"
        //     }
        // }
    }
}
