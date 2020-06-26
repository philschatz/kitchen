import { Replace, DumpBucket } from './types-replacer'

// This is an example Replacer file. It is a JSX version of the XML file with the same name next to this file

export default Replace({selector: 'h:body'}, (t) => {
    const solutionBucket = t.newBucket()
    const chapterCounter = t.newCounter("*[@data-type='chapter']", 1)

    t.newReplace({selector: "*[@data-type='chapter']"}, (t) => {
        const sectionCounter = t.newCounter("*[@data-type='page']", 0)
        const exerciseCounter = t.newCounter("*[@data-type='exercise']", 1)
        const figureCounter = t.newCounter("h:figure", 1)
        const tableCounter = t.newCounter("h:table", 1)

        const keyEquationsBucket = t.newBucket()
        const summaryBucket = t.newBucket()
        const exercisesBucket = t.newBucket()
        const glossaryBucket = t.newBucket()

        return <thiz>
            <children/>
            
            <h2>Key Equations</h2>
            <DumpBucket bucket={keyEquationsBucket}/>

            <h2>Summary</h2>
            <DumpBucket bucket={summaryBucket}/>

            /* ... */
        </thiz>
    })

    return <thiz>
        <children/>
        <div data-type="composite-chapter"
              data-uuid-key=".solution"
              class="os-eob os-solution-container">
            <h1 data-type="document-title">
               <span class="os-text">Answer Key</span>
            </h1>
            <DumpBucket bucket={solutionBucket}
                    group-by="*[@data-type='chapter']"
                    group-by-title="./*[@data-type='document-title']"/>
         </div>
    </thiz>
})