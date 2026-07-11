FROM node:20-alpine

WORKDIR /app

RUN corepack enable \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

COPY package.json yarn.lock* tsconfig.json ./
RUN yarn install --frozen-lockfile --production=false

COPY src ./src

VOLUME /app/db

# 默认同步中国区到国际区，可通过 docker-compose command 覆盖
CMD ["yarn", "sync_cn"]
