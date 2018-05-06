import requests

def test_socket(Socket):
    assert Socket('tcp://0.0.0.0:8200').is_listening


def test_vault_config(File):
    config_hcl = File("/vault/config/config.hcl")
    assert config_hcl.user == "vault"
    assert config_hcl.contains('address = "0.0.0.0:8200"')
    assert config_hcl.contains('tls_disable = 1')
    assert config_hcl.contains('disable_mlock = false')


def test_users(User):
    user = User("vault")
    assert user.exists


def test_status():
    status = requests.get("http://127.0.0.1:8200/v1/sys/health")
    assert status.json()['sealed']
    assert not status.json()['initialized']
