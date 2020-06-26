
// These are just the type signatures but they would contain the actual guts of the baking framework
// There is an XSLT implementation so it's not impossible to implement in JS instead

export const DumpBucket = ({bucket}:{bucket:Bucket}) => 0

// Just a baton/token object. It does not need any public methods
export class Bucket {}
export class Counter {}
export type Builder = {
    newBucket: () => Bucket
    newCounter: (selector: string, startAt: number) => Counter
    newReplace: ({selector,moveTo}:{selector:string,moveTo?:Bucket}, fn: (t:Builder)=>void) => void
}
export const Replace = ({selector,moveTo}:{selector:string,moveTo?:Bucket}, fn: (t:Builder)=>void) => {}
