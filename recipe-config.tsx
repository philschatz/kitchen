import {Root, ChapterGlossary, ChapterPage, BookPageSolutions, Index, Note, TableCaption, FigureCaption, DumpCounter, PARTS, PLACEMENT} from './types-config'

// This describes a recipe. When it runs, it could...
//   - generate a Replacer .tsx file
//   - generate an XML file that is fed into saxon
//   - run the actual baking somehow
//
// What are the pros/cons of the different options?


// This is just a JSX version of the XML file with the same name next to this file

export default <Root>

    <ChapterGlossary name='Key Terms'/>
    <ChapterPage class_='key-equations' cluster={false} name='Key Equations'/>
    <ChapterPage class_='summary'       cluster={true}  name='Summary'/>
    <ChapterPage class_='exercises'     cluster={true}  name='Exercises'/>


    <BookPageSolutions class_='solution' cluster={true} name='Answer Key'/>
    <Index name='Index'/>

    <Note class_='link-to-learning' name='Link to Learning'/>
    <Note class_='sciences-interconnect' name='How Sciences Interconnect'/>
    <Note class_='chemist-portrait' name='Portrait of a Chemist'/>
    <Note class_='everyday-life' name='Chemistry in Everyday Life'/>

    <TableCaption in_={PARTS.CHAPTER} placement={PLACEMENT.BOTTOM}>
        <span class_='os-title-label'>Table </span>
        <span class_='os-number'>
            <DumpCounter name='chapterCounter'/>.<DumpCounter name='tableCounter'/>
        </span>
        <span class_='os-divider'> </span>
    </TableCaption>

    <FigureCaption in_={PARTS.CHAPTER} placement={PLACEMENT.TOP}>
        <span class_='os-title-label'>Figure </span>
        <span class_='os-number'>
            <DumpCounter name='chapterCounter'/>.<DumpCounter name='figureCounter'/>
        </span>
        <span class_='os-divider'> </span>
    </FigureCaption>

</Root>