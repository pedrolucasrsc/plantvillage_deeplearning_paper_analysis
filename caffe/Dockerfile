FROM bvlc/caffe:cpu
WORKDIR /TCC

# ----------------------------------------------------------------- requirements
COPY scripts/install_requirements.sh ./install_requirements.sh
RUN bash install_requirements.sh && rm install_requirements.sh

# ----------------------------------------------------------------- project code
COPY src                 src
COPY scripts             scripts
COPY train               train
COPY generalization_test generalization_test
COPY entrypoint.sh       entrypoint.sh
RUN chmod +x entrypoint.sh

CMD ["bash","/TCC/entrypoint.sh"]

