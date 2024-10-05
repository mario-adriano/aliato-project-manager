import { createConsumer } from "@rails/actioncable"

export const consumer = createConsumer()

import "channels/admin/phases_channel"