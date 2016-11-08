from behave import *
import unirest as uni


@when('I (?P<method>add|overwrite) hosts?')
def step_impl(context, method):
    port = context.heamon.port
    for row in context.table:
        id, hostname = row['id'], row['hostname']
        response = uni.put('http://localhost:{}/api/1/host/{}/{}'.format(port,
            id, hostname))
        assert response.code == 201 if method == 'add' else 200


@when('I get all hosts')
def step_impl(context):
    port = context.heamon.port
    response = uni.get('http://localhost:{}/api/1/hosts'.format(port))
    assert response.code == 200
    context.reponse = response.body


@when('I delete ?(?P<state>existing)? hosts?')
def step_impl(context, state):
    port = context.heamon.port
    response = uni.delete('http://localhost:{}/api/1/host/{}'.format(port, id))
    assert response.code == 202 if state == 'existing' else 204


@then('I get the following hosts?')
def step_impl(context):
    response = context.response.pop()
    content = response.content
    assert response.code == 200
    for row in context.table:
        k, v = row['id'], row['hostname']
        assert k in content
        assert content[k] == v
        del content[k]
    assert len(content) == 0


@then('I get an empty list of hosts')
def step_impl(context):
    context.exectute_steps('''
        I get the following hosts
            | id | hostname |
    ''')

class Response:

    def __init__(code, content):
        self._code = code
        self._content = content

    @property
    def code(self):
        return self._code

    @property
    def content(self):
        return self._body
