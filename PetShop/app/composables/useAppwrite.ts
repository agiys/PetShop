import { Client } from 'appwrite'

export const useAppwrite = () => {
    const client = new Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('664df1090031f0ba653e');
    return client
}