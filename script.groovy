def buildApp() {
    echo 'building the applictaion'
}

def testApp() {
    echo 'testing the applictaion'
}

def deployApp() {
    echo 'deploying the applictaion'
    echo "deploying version ${params.VERSION}"
}

return this