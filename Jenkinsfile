def PLATFORMS
def BUILD_PLATFORM
def GIT_SHA

pipeline {
    agent {
        label 'pipeline'
    }
    options {
        buildDiscarder(
            logRotator(numToKeepStr: '50')
        )
        preserveStashes(buildCount: 5)
        skipStagesAfterUnstable()
        timeout(time:12, unit: 'HOURS')
        timestamps()
    }
    parameters {
        choice(
            name: 'GIT_SHA',
            description: 'Select a commit from the repository.'
        )
        choice(
            name: 'PLATFORM',
            choices: get_make_targets(),
            description: 'Select a PLATFORM from the target.mk.'
        )
        string(defaultValue: '--jobs=$(nproc)', description: 'Flags to run make with?', name: 'MAKE_BUILD_FLAGS')

    }


    stages {
        stage('preliminaries') {
            agent {
                label 'trivial'
            }
            steps {
                script {
                    PLATFORMS = readJSON file:'ci/targets.json'
                    BUILD_PLATFORM = params.PLATFORM
                    if (BUILD_PLATFORM == 'debian-all') {
                        BUILD_PLATFORM = 'debian'

                    } else if (PLATFORMS[BUILD_PLATFORM].parent) {
                        BUILD_PLATFORM = PLATFORMS[BUILD_PLATFORM].parent
                    }
                    TESTABLE_PLATFORMS = PLATFORMS.findAll({x -> x.value.testable == true }).keySet() as String[]
                }
            }
        }
    }
}

def get_make_targets() {
    def make_cmd = "make -s -f ./Makefile main-targets -s -f ./Makefile | grep -o '\\S.*'"
    def proc = "git show ${params.GIT_SHA}:.".execute()
    proc.waitFor()
    def output = proc.in.text
    def targets_proc = make_cmd.execute([], new File("."))
    targets_proc.waitFor()
    echo "${targets_output}"
    def targets_output = targets_proc.in.text
    return targets_output.tokenize("\n")
}