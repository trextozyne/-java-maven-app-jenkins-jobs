def buildApp() {
    echo 'building the applictaion'
}

def testdApp() {
    echo 'testing the applictaion'
}

def deploy App() {
    echo 'deploying the applictaion'
    echo "deploying version ${params.VERSION}"
}

return this