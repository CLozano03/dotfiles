genpasswd() {
    password_length=$1

    # If no length or is lower than 5 is 12
    if [ -z "$1" ] || [ "$1" -lt 5 ]; then
      password_length=12
    fi

    python3 -c "import secrets; print(secrets.token_urlsafe("$password_length"))"
}
