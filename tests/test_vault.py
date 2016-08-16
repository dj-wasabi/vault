
def test_socker(Socket):
    assert Socket('tcp://:::8200').is_listening


# def test_user_details(User):
#     my_user = User("kibana")
#     assert my_user.uid == 999
#     assert my_user.home == '/opt/kibana'


def test_jenkins_key_public(File):
    passwd = File("/vault/config.hcl")
    assert passwd.user == "root"
    assert passwd.contains('address = "0.0.0.0:8200"')

