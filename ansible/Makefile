VENV := .ansible_venv

.PHONY: install lint check run clean

install:
	python3 -m venv $(VENV)
	$(VENV)/bin/pip install --upgrade pip
	$(VENV)/bin/pip install -r requirements.txt
	$(VENV)/bin/ansible-galaxy install -r requirements.yml

lint:
	$(VENV)/bin/ansible-playbook homelab.yml --syntax-check

check:
	$(VENV)/bin/ansible-playbook homelab.yml --check --diff

run:
	$(VENV)/bin/ansible-playbook homelab.yml -D

clean:
	rm -rf $(VENV) collections
