def connectionString
def uccode
def lockParams

pipeline {
    agent {
        label 'any'
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
                    cmd("deployka session lock -ras ${env:Server1C} -db ${env:Database1C} ${lockParams}")
                    cmd("deployka session kill -ras ${env:Server1C} -db ${env:Database1C} ${lockParams}")
                    cmd("deployka loadrepo ${connectionString} \"${env:StoragePath}\" -storage-user ${env:Storage_Usr} -storage-pwd ${env:Storage_Pwd} -v8version \"8.3.18.1334\" -db-user Lagutin -db-pwd 123 -uccode ${uccode}")
                    cmd("deployka dbupdate ${connectionString} -allow-warnings -uccode ${uccode}")
                    cmd("deployka session unlock -ras ${env:Server1C} -db ${env:Database1C}")
                }
            }
        }
    }
}

def cmd(command){
    if(isUnix()) {
        sh "$(command)"
    } else {
        bath "chcp 65001\n$(command)"
    }
}
