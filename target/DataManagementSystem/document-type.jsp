<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Choose document type</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/font-awesome/css/font-awesome.min.css">

    <link rel="stylesheet" href="style/document-type.css"/>

</head>
<body>

<main role="main">
    <div class="container">
        <div class="center">
            <form action="CreateDocument" method="post">
                <div class="row">
                    <div class="col-md-4">
                        <nav class="nav">

                            <ul class="metisFolder metismenu">
                                <li>
                                    <a href="#">
                                        <span class="fa fa-fw fa-folder-o fa-2x"></span>
                                        Document
                                    </a>
                                    <ul>
                                        <li>
                                            <span class="fa fa-fw fa-file-pdf-o text-danger fa-2x"></span>
                                            <input type="radio" name="radio" value="pdf"/>
                                            2D drawing
                                        </li>
                                        <li>
                                            <span class="fa fa-fw fa-file-word-o text-primary fa-2x"></span>
                                            <input type="radio" name="radio" value="doc"/>
                                            Doc
                                        </li>

                                        <li>
                                            <span class="fa fa-fw fa-file-image-o fa-2x"></span>
                                            <input type="radio" name="radio" value="image"/>
                                            Image
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                            </li>
                            </ul>

                        </nav>
                    </div>
                    <!-- /.col-md-4 -->

                </div>
                <!-- /.row -->
                <div class="buttons">
                    <ul>
                        <li><input class="button" type="submit" name="submit" value="OK" onclick="popupClose()"></li>
                        <li><input class="button" type="button" name="Cancel" value="Cancel" onclick="popupClose()"></li>
                        <script src="jsscripts/popupwindow.js"></script>
                    </ul>
                </div>
            </form>
        </div>
        <!-- /.container -->
    </div>
</main>

<script src="jsscripts/menutree.js"></script>
<script src="jsscripts/foldertree.js"></script>

</body>
</html>
