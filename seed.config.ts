import { SeedPg } from "@snaplet/seed/adapter-pg";
import { defineConfig } from "@snaplet/seed/config";
import {Client} from "pg";

export default defineConfig({
  alias: {
    inflection: true,
  },
  adapter: async () => {
    const client = new Client({ connectionString: 'postgresql://postgres:postgres@127.0.0.1:64322/postgres'  });
    await client.connect();
    return new SeedPg(client);
  },
  select: [
    // We don't alter any extensions tables that might be owned by extensions
    "!*",
    // We want to alter all the tables under public schema
    "public*",
    // We also want to alter some of the tables under the auth schema
  ]
});
