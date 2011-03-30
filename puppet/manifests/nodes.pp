node basenode {
    include common
}

node <your_host> inherits basenode {
    include role_web
}
