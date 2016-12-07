node() {

    def err = null
    currentBuild.result = "SUCCESS"

    try {
        stage("Checkout") {
            checkout scm
        }

        stage("Checkout") {
            sh 'docker build -t vaulttest .'
        }


        gitTag()

        stage("'Docker tag & Push") {
            sh 'docker tag vaulttest 192.168.1.210:5000/vault:$(cat GIT_COMMIT)'
            sh 'docker tag vaulttest 192.168.1.210:5000/vault:latest'
            sh 'docker push 192.168.1.210:5000/vault:$(cat GIT_COMMIT)'
            sh 'docker push 192.168.1.210:5000/vault:latest'
        }

        stage("cleanup") {
            sh 'docker rmi 192.168.1.210:5000/vault:$(cat GIT_COMMIT)'
            sh 'docker rmi 192.168.1.210:5000/vault:latest'
            sh 'docker rmi vaulttest:latest'
        }
    }

    catch (caughtError) {
        err = caughtError
        currentBuild.result = "FAILURE"
        jobFailed()
    }

    finally {
        if (err) {
            throw err
        }
    }
}

def notifyFailed() {
    emailext (
        subject: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
        body: """<p>FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
        <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>""",
        replyTo: 'jenkins@dj-wasabi.nl',
        to: 'werner@dj-wasabi.nl',
        attachLog: true
    )
}

def removeTest() {
    stage("Remove containers") {
        sh 'docker kill vaulttest consultest'
        sh 'docker rm vaulttest consultest'
    }
}

def jobFailed() {
    removeTest()
    sh 'docker rmi vaulttest'
    sh 'docker rmi $(docker images | grep "^<none" | awk "{print $3}")'
}

def gitTag() {
    stage("Git Tag") {
        sh 'git rev-parse HEAD | cut -c1-12 > GIT_COMMIT'
        sh '''if git rev-parse -q --verify "refs/tags/$(cat GIT_COMMIT)" >/dev/null; then
                  echo "Current tag found"
              else
                  git config --global user.email "jenkins@dj-wasabi.local"
                  git config --global user.name "Jenkins"

                  git tag -m $(cat GIT_COMMIT) -a $(cat GIT_COMMIT)
                  git push --tags
              fi'''
    }
}
