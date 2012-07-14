
class MM(object):
    def __init__(self, value):
        self.value = value

function_code = raw_input("Enter the function you're using: ")
function_lambda = eval("lambda x: " + function_code)

print function_lambda("test")
