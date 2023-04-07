pipeline {
    agent any
    // environment {
    //     TAG = "trancongbao/maintenance:v1"
    // }

    stages {
        stage("Build and push Docker image.") {
            steps {
                script {
                    echo "$BRANCH_NAME"
                    sh "git checkout $BRANCH_NAME"
                    sh "git pull --force"
                    sh "git fetch --tags --force"
                    sh "git tag"
                    def versionDescriptors = sh(returnStdout: true, script: 'git describe --tags --dirty').trim().split('-', 2).toList()
                    if (versionDescriptors.size() > 1) { //pre-release
                        versionDescriptors[1] = versionDescriptors[1].replaceFirst("-", ".")
                        versionDescriptors.add("SNAPSHOT")
                    }
                    def version = versionDescriptors.join("-")
                    echo "version: $version"
                    def TAG = "trancongbao/maintenance:$version"
                    sh "docker build -t $TAG ."
                    withCredentials([usernamePassword(credentialsId: 'dockerHub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh "docker login -u $USERNAME -p $PASSWORD"
                        sh "docker push $TAG"
                    } 
                }
            }
        }
    }
}