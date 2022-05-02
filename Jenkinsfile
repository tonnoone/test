def connectionString
def uccode
def lockParams

pipeline {
    agent {
        label 'Win037'
    }

    environment {
        Storage = credentials('Storage_CIBot')
        Cluster_Admin = credentials('monitor1c')
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
                    cmd("deployka session lock -ras ${env:Server1C} -db ${env:Database1C} ${lockParams} -db-user ci-bot -db-pwd 123 -cluster-admin ${Cluster_Admin_Usr} -cluster-pwd ${Cluster_Admin_Psw}")
                    cmd("deployka session kill -ras ${env:Server1C} -db ${env:Database1C} ${lockParams} -db-user ci-bot -db-pwd 123 -cluster-admin ${Cluster_Admin_Usr} -cluster-pwd ${Cluster_Admin_Psw}")
                    cmd("net use H: \\\\1c-as038\\REPO\\smoke_tests AccuSync2007 /USER:1c-as038\\jenkins")
                    cmd("deployka loadrepo ${connectionString} \"H:\" -storage-user ${env:Storage_Usr} -storage-pwd ${env:Storage_Psw} -v8version \"8.3.18.1334\" -db-user ci-bot -db-pwd 123 -uccode ${uccode}")
                    cmd("deployka dbupdate ${connectionString} -allow-warnings -uccode ${uccode} -db-user ci-bot -db-pwd 123 -v8version \"8.3.18.1334\"")
                    cmd("deployka session unlock -ras ${env:Server1C} -db ${env:Database1C} -db-user ci-bot -db-pwd 123")
                    cmd("net use H: /DELETE")
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
