import pickle

class Concept(object):
    def __init__(self, name, understand, describe):
        self.name       = name
        self.understand = understand
        self.describe   = describe

fd_knowledge = open('knowledge.pick', 'wr')
knowledge = dict() # pickle.load(fd_knowledge)

def process(line, concept_name):
    stack = list([ (line, concept_name) ])
    while stack:
        v, concept_name = stack.pop()

        if concept_name == None:
            for name in knowledge:
                concept = knowledge[name]
                if concept.describe is not None and concept.describe(v):
                    ans = raw_input('Is '+ str(v) + ' a ' + concept.name + ' ? ')
                    if ans == 'y':
                        concept_name = concept.name
            if concept_name == None:
                continue

        if concept_name not in knowledge:
            knowledge[concept_name] = Concept(concept_name, None, None)
        concept = knowledge[concept_name]

        if concept.describe == None:
            function_code = raw_input('How do you describe ' + concept.name + ' ?\n' +
                                      'lambda x: ')
            concept.describe = eval("lambda x: " + function_code)
            knowledge[concept.name] = concept

        if concept.understand == None:
            function_code = raw_input('How do you understand ' + concept.name + ' ?\n' +
                                      'lambda x: ')
            concept.understand = eval("lambda x: " + function_code)
            knowledge[concept.name] = concept

        print v + ' is ' + concept.name
        stack.extend(concept.understand(v))
        pickle.dump(knowledge, fd_knowledge)

def main():
    while True:
        line = raw_input('$ ')
        process(line, 'Sentence')

main()
