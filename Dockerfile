# হালকা একটি লিনাক্স ওএস (Alpine) নিচ্ছি
FROM alpine:latest

# sslh এবং প্রয়োজনীয় টুল ইনস্টল করছি
RUN apk add --no-cache sslh wget tar

# FRP-এর রিলিজ ডাউনলোড এবং সেটআপ করছি
ENV FRP_VERSION=0.57.0
RUN wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz && \
    tar xzf frp_${FRP_VERSION}_linux_amd64.tar.gz && \
    mv frp_${FRP_VERSION}_linux_amd64 /frp && \
    rm frp_${FRP_VERSION}_linux_amd64.tar.gz

# আমাদের বানানো ফাইলগুলো কনটেইনারে কপি করছি
COPY frps.toml /frp/frps.toml
COPY start.sh /start.sh

# স্ক্রিপ্টটি চালানোর পারমিশন দিচ্ছি
RUN chmod +x /start.sh

# কনটেইনার চালু হলে এই কমান্ডটি রান করবে
CMD ["/start.sh"]
