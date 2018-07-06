#/bin/sh

for f in /docker-entrypoint-init.d/*; do
    case "$f" in
        *.sh)  echo "Running $f"; . "$f" ;;
        *)     echo "Ignoring $f" ;;
    esac
    echo
done

cd /etc/nginx
exec "$@"
