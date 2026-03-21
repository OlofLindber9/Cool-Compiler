/**
 * Exception class for C-- throw/catch statements.
 * Wraps an integer value as the exception payload.
 */
public class CMMException extends RuntimeException {
    public final int value;

    public CMMException(int value) {
        super("CMMException: " + value);
        this.value = value;
    }
}
