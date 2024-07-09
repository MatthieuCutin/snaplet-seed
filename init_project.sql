CREATE TABLE "channel" (
                           "id" UUID NOT NULL,
                           "name" TEXT NOT NULL,
                           "is_public" BOOLEAN NOT NULL,
                           "workspace_id" UUID NOT NULL,
                           "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT (CURRENT_TIMESTAMP),
                           "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT (CURRENT_TIMESTAMP),
                           "author_id" UUID NOT NULL,
                           PRIMARY KEY ("id")
);

CREATE TABLE "channel_member" (
                                  "channel_id" UUID NOT NULL,
                                  "user_id" UUID NOT NULL,
                                  "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT (CURRENT_TIMESTAMP),
                                  "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT (CURRENT_TIMESTAMP),
                                  PRIMARY KEY ("channel_id", "user_id")
);

CREATE TABLE "channel_thread" (
                                  "id" UUID NOT NULL,
                                  "channel_id" UUID NOT NULL,
                                  "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT (CURRENT_TIMESTAMP),
                                  "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT (CURRENT_TIMESTAMP),
                                  PRIMARY KEY ("id")
);

CREATE TABLE "channel_thread_message" (
                                          "id" UUID NOT NULL,
                                          "author_id" UUID NOT NULL,
                                          "channel_thread_id" UUID NOT NULL,
                                          "message" TEXT NOT NULL,
                                          "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT (CURRENT_TIMESTAMP),
                                          "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT (CURRENT_TIMESTAMP),
                                          PRIMARY KEY ("id")
);

CREATE TABLE "user_message" (
                                "id" UUID NOT NULL,
                                "author_id" UUID NOT NULL,
                                "recipient_id" UUID NOT NULL,
                                "message" TEXT NOT NULL,
                                "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT (CURRENT_TIMESTAMP),
                                "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT (CURRENT_TIMESTAMP),
                                PRIMARY KEY ("id")
);

CREATE TABLE "users" (
                         "id" UUID NOT NULL,
                         "name" TEXT NOT NULL,
                         "email" TEXT NOT NULL,
                         "display_name" TEXT,
                         "bio" TEXT,
                         "phone_number" TEXT,
                         "timezone" TEXT,
                         "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT (CURRENT_TIMESTAMP),
                         "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT (CURRENT_TIMESTAMP),
                         "last_seen" TIMESTAMPTZ(6),
                         "password" TEXT NOT NULL,
                         PRIMARY KEY ("id")
);

CREATE TABLE "workspace" (
                             "id" UUID NOT NULL,
                             "name" TEXT NOT NULL,
                             "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT (CURRENT_TIMESTAMP),
                             "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT (CURRENT_TIMESTAMP),
                             "url_slug" TEXT NOT NULL,
                             PRIMARY KEY ("id")
);

CREATE TABLE "workspace_member" (
                                    "user_id" UUID NOT NULL,
                                    "workspace_id" UUID NOT NULL,
                                    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT (CURRENT_TIMESTAMP),
                                    "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT (CURRENT_TIMESTAMP),
                                    "type" TEXT NOT NULL DEFAULT 'member',
                                    PRIMARY KEY ("user_id", "workspace_id")
);

CREATE TABLE "workspace_user_type" (
                                       "type" TEXT NOT NULL,
                                       PRIMARY KEY ("type")
);

CREATE UNIQUE INDEX "workspace_name_key" ON "workspace" ("name");

CREATE UNIQUE INDEX "workspace_url_slug_key" ON "workspace" ("url_slug");

ALTER TABLE "channel" ADD CONSTRAINT "channels_workspace_id_fkey" FOREIGN KEY ("workspace_id") REFERENCES "workspace" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE "channel" ADD CONSTRAINT "channel_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE "channel_member" ADD CONSTRAINT "channel_member_channel_id_fkey" FOREIGN KEY ("channel_id") REFERENCES "channel" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE "channel_member" ADD CONSTRAINT "channel_member_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE "channel_thread" ADD CONSTRAINT "channel_thread_channel_id_fkey" FOREIGN KEY ("channel_id") REFERENCES "channel" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE "channel_thread_message" ADD CONSTRAINT "channel_thread_message_channel_thread_id_fkey" FOREIGN KEY ("channel_thread_id") REFERENCES "channel_thread" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE "channel_thread_message" ADD CONSTRAINT "channel_thread_message_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE "user_message" ADD CONSTRAINT "user_message_recipient_id_fkey" FOREIGN KEY ("recipient_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE "user_message" ADD CONSTRAINT "user_message_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE "workspace_member" ADD CONSTRAINT "workspace_member_type_fkey" FOREIGN KEY ("type") REFERENCES "workspace_user_type" ("type") ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE "workspace_member" ADD CONSTRAINT "workspace_members_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE "workspace_member" ADD CONSTRAINT "workspace_members_workspace_id_fkey" FOREIGN KEY ("workspace_id") REFERENCES "workspace" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;
