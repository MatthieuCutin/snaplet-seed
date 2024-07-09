/**
 * ! Executing this script will delete all data in your database and seed it with 10 workspace_user_type.
 * ! Make sure to adjust the script to your needs.
 * Use any TypeScript runner to run this script, for example: `npx tsx seed.ts`
 * Learn more about the Seed Client by following our guide: https://docs.snaplet.dev/seed/getting-started
 */
import { createSeedClient } from "@snaplet/seed";
import {copycat} from "@snaplet/copycat";

const main = async () => {
  const seed = await createSeedClient();

  // Truncate all tables in the database
  await seed.$resetDatabase();

    // Create a pool of 5 users for our workspace
    const { users } = await seed.users((x) => x(5));
    const workspacesNumber = 1;
    // Create our workspace and connect all our users to it
    const { workspace, workspace_member } = await seed.workspace((x) =>
        x(workspacesNumber, () => ({
                // Each workspace will have between 1 and 10 members
                workspace_member: (x) => x(users.length)
            }),
            // Connect the workspace members to the pool of users we created
            { connect: { users }})
    );



  process.exit();
};

main();
