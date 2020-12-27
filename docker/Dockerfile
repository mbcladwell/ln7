# Use the official image as a parent image.
FROM limsn
# Add metadata to the image to describe which port the container is listening on at runtime.
ENV PATH "$PATH:/usr/local/bin"   ## for art
ENV TERM xterm
EXPOSE 3000
WORKDIR "/home/ln7/lnserver"

## 
## CMD ["/usr/local/bin/art work"]
## CMD ["sleep 120"]

## RUN /usr/local/bin/art work --refresh
### https://stackoverflow.com/questions/26598738/how-to-create-user-database-in-script-for-docker-postgres
### https://stackoverflow.com/questions/37836764/run-command-in-docker-container-only-on-the-first-start
# docker build . --tag limsn

ENTRYPOINT ["/bin/nano" "ENTRY"]
# docker run --rm  limsnrun
# docker exec -it artcli /bin/bash     ;;to get into the container


# docker run --rm -p 6543:5432 -v $HOME/docker/volumes/postgres:/var/lib/postgresql/data limsnrun
