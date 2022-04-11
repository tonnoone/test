def connectionString
def uccode
def lockParams

pipeline {
    agent {
        label 'Win036'
    }

    environment {
        Storage = credentials('Storage_CIBot')
    }
    stages {
        stage('Обновление тестового контура') {
            steps {
                timestamps {
                    script {
                        connectionString    = "\"/S${env:Server1C}\\${env:Database1C}\""
                        uccode              = "\"123\""
                        lockParams          = "-lockmessage \"test\" -lockuccode ${uccode}"
                    }
                    cmd("deployka session lock -ras ${env:Server1C} -db ${env:Database1C} ${lockParams} -db-user ci-bot -db-pwd 123")
                    cmd("deployka session kill -ras ${env:Server1C} -db ${env:Database1C} ${lockParams} -db-user ci-bot -db-pwd 123")
                    cmd("deployka loadrepo ${connectionString} \"${env:StoragePath}\" -storage-user ${env:Storage_Usr} -storage-pwd ${env:Storage_Psw} -v8version \"8.3.18.1334\" -db-user ci-bot -db-pwd 123 -uccode ${uccode}")
                    cmd("deployka dbupdate ${connectionString} -allow-warnings -uccode ${uccode} -db-user ci-bot -db-pwd 123 -v8version \"8.3.18.1334\"")
                    cmd("deployka session unlock -ras ${env:Server1C} -db ${env:Database1C} -db-user ci-bot -db-pwd 123")
                }
            }
        }

        stage('Проверка поведения') {
            steps {
                timestamps {
                    cmd("vrunner vanessa --vanessasettings ./tools/VBParams.json --workspace . --ibconnection ${connectionString} --db-user ci-bot --db-pwd 123 --v8version \"8.3.18.1334\"")
                }
            }
        }
    }
    post {
        always {
            allure includeProperties: false, jdk: '', results: [[path: 'allure/json_for_allure']]
        }
    }
}

def cmd(command){
    if(isUnix()) {
        sh "${command}"
    } else {
        bat "chcp 65001\n${command}"
    }
}
