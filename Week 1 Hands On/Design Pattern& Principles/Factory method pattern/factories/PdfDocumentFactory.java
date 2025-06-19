package factories;
import documents.Document;
import documents.PdfDocument;

public class PdfDocumentFactory extends DocumentFactory {
	public Document createDocument() {
        return new PdfDocument();
    }
}
