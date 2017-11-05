<!-- Index.html -->

\Title(title)
\Layout("Default")

<h1>Squirrels</h1>

\for image in images {
    <img src="\(image.src)" alt="\(image.description)">
\}
