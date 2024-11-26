.PHONY: venv
venv:
	uv venv --python 3.12 .venv

.PHONY: deps
deps: venv
	. .venv/bin/activate && uv pip install ansible

.PHONY: prepare
prepare: deps
	. .venv/bin/activate && ansible-galaxy install -r requirements.yml
	. .venv/bin/activate && ansible-playbook -i inventory.ini playbook.yml
