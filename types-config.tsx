
// The config converter code would go in these components... they could:
//   - generate a Replacer .tsx file
//   - generate an XML file that is fed into saxon
//   - run the actual baking somehow
//
// What are the pros/cons of the different options?

export const Root = () => (<root>{this.children}</root>)
export const ChapterGlossary = ({name}: {name:string}) => (<chapter-glossary name={name}/>)
export const ChapterPage = ({class_, cluster, name}: {class_:string,cluster:boolean,name:string}) => (<chapter-page class={class_} cluster={cluster} name={name}/>)
export const BookPageSolutions = ({class_, cluster, name}: {class_:string,cluster:boolean,name:string}) => (<book-page-solutions class={class_} cluster={cluster} name={name}/>)
export const Index = ({name}: {name:string}) => (<index name={name}/>)
export const Note = ({class_, name}: {class_:string,name:string}) => (<note class={class_} name={name}/>)
export const TableCaption = ({in_,placement}:{in_:PARTS,placement:PLACEMENT}) => (<table-caption in={in_} placement={placement}>{this.children}</table-caption>)
export const FigureCaption = ({in_,placement}:{in_:PARTS,placement:PLACEMENT}) => (<figure-caption in={in_} placement={placement}>{this.children}</figure-caption>)
export const DumpCounter = ({name}:{name:string}) => (<dump-counter name={name}>{this.children}</dump-counter>)

export enum PARTS {
    CHAPTER = 'CHAPTER_PART',
    APPENDIX = 'APPENDIX_PART',
    ANY = 'ANY_PART',
}

export enum PLACEMENT {
    BOTTOM = 'BOTTOM',
    TOP = 'TOP',
}