To install a systemd unit, run:

```bash
export UNIT=tandoor

sudo cp "$UNIT.service" /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable "$UNIT.service"
sudo systemctl start "$UNIT.service"
```